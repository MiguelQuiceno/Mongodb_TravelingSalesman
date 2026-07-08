// ============================================================
// 03_mongodb_tsp.js  —  TSP resuelto 100% dentro de MongoDB (mongosh)
// Ejecutar:  mongosh 03_mongodb_tsp.js
//
// Para cada N en {4,6,8,...,20}:
//   1. Lee las distancias del subgrafo (ciudades 1..N) DESDE las
//      colecciones de MongoDB (db.distancias).
//   2. Resuelve el TSP de forma EXACTA con dos algoritmos:
//        a) Fuerza bruta con poda (limite de tiempo configurable)
//        b) Held-Karp (programacion dinamica, O(n^2 * 2^n))
//   3. Imprime tiempo de ejecucion y solucion (costo + ruta).
// ============================================================
db = db.getSiblingDB("tsp");

const LIMITE_FUERZA_BRUTA_MS = 120000; // 2 min max por N en fuerza bruta
const TAMANOS = [4, 6, 8, 10, 12, 14, 16, 18, 20];

// ---- Lee la matriz de distancias del subgrafo 1..N desde MongoDB ----
function leerMatriz(N) {
  const D = Array.from({ length: N }, () => new Array(N).fill(0));
  db.distancias.find({ o: { $lte: N }, d: { $lte: N } }).forEach(e => {
    D[e.o - 1][e.d - 1] = e.km;
  });
  return D;
}

// ---- Fuerza bruta con poda (branch & bound) ----
function fuerzaBruta(D, limiteMs) {
  const n = D.length, t0 = Date.now();
  let mejor = Infinity, mejorRuta = null, timeout = false, llamadas = 0;
  const visitado = new Array(n).fill(false); visitado[0] = true;
  const camino = [0];
  function rec(actual, costo) {
    if (timeout) return;
    if (((++llamadas) & 8191) === 0 && Date.now() - t0 > limiteMs) { timeout = true; return; }
    if (costo >= mejor) return; // poda
    if (camino.length === n) {
      const total = costo + D[actual][0];
      if (total < mejor) { mejor = total; mejorRuta = camino.slice().concat(0); }
      return;
    }
    for (let k = 1; k < n; k++) {
      if (visitado[k]) continue;
      visitado[k] = true; camino.push(k);
      rec(k, costo + D[actual][k]);
      visitado[k] = false; camino.pop();
    }
  }
  rec(0, 0);
  return { costo: mejor, ruta: mejorRuta, timeout: timeout };
}

// ---- Held-Karp exacto (DP sobre subconjuntos), ciudad 1 fija ----
function heldKarp(D) {
  const n = D.length, m = n - 1, FULL = 1 << m;
  const dp  = new Float64Array(FULL * m).fill(Infinity);
  const par = new Int8Array(FULL * m).fill(-1);
  for (let j = 0; j < m; j++) dp[(1 << j) * m + j] = D[0][j + 1];
  for (let mask = 1; mask < FULL; mask++) {
    for (let j = 0; j < m; j++) {
      if (!(mask & (1 << j))) continue;
      const cur = dp[mask * m + j];
      if (cur === Infinity) continue;
      for (let k = 0; k < m; k++) {
        if (mask & (1 << k)) continue;
        const nm = mask | (1 << k), cand = cur + D[j + 1][k + 1];
        if (cand < dp[nm * m + k]) { dp[nm * m + k] = cand; par[nm * m + k] = j; }
      }
    }
  }
  let mejor = Infinity, ultimo = -1;
  const full = FULL - 1;
  for (let j = 0; j < m; j++) {
    const c = dp[full * m + j] + D[j + 1][0];
    if (c < mejor) { mejor = c; ultimo = j; }
  }
  const ruta = []; let mask = full, j = ultimo;
  while (j !== -1) { ruta.push(j + 1); const p = par[mask * m + j]; mask ^= (1 << j); j = p; }
  ruta.push(0); ruta.reverse(); ruta.push(0);
  return { costo: mejor, ruta: ruta };
}

function fmtRuta(r) { return r.map(i => i + 1).join(" -> "); }

// =============================== EJECUCION ===============================
print("==========================================================================");
print(" TSP en MongoDB (mongosh / JavaScript) — grafo leido de db.distancias");
print("==========================================================================");
print("");

TAMANOS.forEach(N => {
  // El tiempo medido incluye la lectura del grafo desde MongoDB + el calculo
  let t0 = Date.now();
  let D = leerMatriz(N);
  const bf = fuerzaBruta(D, LIMITE_FUERZA_BRUTA_MS);
  const tBF = Date.now() - t0;

  t0 = Date.now();
  D = leerMatriz(N);
  const hk = heldKarp(D);
  const tHK = Date.now() - t0;

  print("-------------------------------------------------------------------------");
  print("N = " + N + " ciudades");
  if (bf.timeout) {
    print("  Fuerza bruta : NO TERMINO en " + (LIMITE_FUERZA_BRUTA_MS / 1000) + " s (explosion factorial)");
  } else {
    print("  Fuerza bruta : " + tBF + " ms   | costo optimo = " + bf.costo + " km");
  }
  print("  Held-Karp    : " + tHK + " ms   | costo optimo = " + hk.costo + " km");
  print("  Ruta optima  : " + fmtRuta(hk.ruta));
});
print("-------------------------------------------------------------------------");
print("Fin. Tiempos medidos con Date.now() dentro de mongosh (todo en MongoDB).");
