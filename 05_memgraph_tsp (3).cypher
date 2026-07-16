// 05_memgraph_tsp.cypher — TSP por busqueda exhaustiva en Cypher puro (Memgraph)
// Ejecutar UNA consulta a la vez (una por cada N) y anotar el tiempo que
// reporta mgconsole / Memgraph Lab al final de cada ejecucion.
// Devuelve la ruta (ids), las ciudades (nombres) y el costo total en km.

// ==================== N = 4 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *4..4 (e, v | v.id <= 4)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 6 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *6..6 (e, v | v.id <= 6)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 8 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *8..8 (e, v | v.id <= 8)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 10 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *10..10 (e, v | v.id <= 10)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 12 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *12..12 (e, v | v.id <= 12)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 14 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *14..14 (e, v | v.id <= 14)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 16 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *16..16 (e, v | v.id <= 16)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 18 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *18..18 (e, v | v.id <= 18)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;

// ==================== N = 20 ciudades ====================
MATCH p = (s:Ciudad {id: 1})-[:DIST *20..20 (e, v | v.id <= 20)]->(s)
WITH [n IN nodes(p) | n.id][0..-1] AS ids,
     [n IN nodes(p) | n.nombre] AS ciudades,
     reduce(t = 0.0, r IN relationships(p) | t + r.km) AS costo
WHERE ALL(i IN range(0, size(ids)-2)
          WHERE ALL(j IN range(i+1, size(ids)-1) WHERE ids[i] <> ids[j]))
WITH ids, ciudades, costo
ORDER BY costo ASC
LIMIT 1
RETURN ids + [1] AS ruta,
       ciudades,
       toString(toInteger(costo)) + " km" AS costo_total;
