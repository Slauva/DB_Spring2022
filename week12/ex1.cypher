// Create nodes and relations
Create
    (kn:Fighter {name: 'Khabib Nurmagomedov',weight:'155'}),
    (rd:Fighter {name: 'Rafael Dos Anjos',weight:'155'}),
    (nm:Fighter {name: 'Neil Magny',weight:'170'}),
    (jj:Fighter {name: 'Jon Jones',weight:'205'}),
    (dc:Fighter {name: 'Daniel Cormier',weight:'205'}),
    (mb:Fighter {name: 'Michael Bisping',weight:'185'}),
    (mh:Fighter {name: 'Matt Hamill',weight:'185'}),
    (bv:Fighter {name: 'Brandon Vera',weight:'205'}),
    (fm:Fighter {name: 'Frank Mir',weight:'230'}),
    (bl:Fighter {name: 'Brock Lesnar',weight:'230'}),
    (kg:Fighter {name: 'Kelvin Gastelum',weight:'185'}),

    (kn)-[:beats]->(rd),
    (rd)-[:beats]->(nm),
    (jj)-[:beats]->(dc),
    (mb)-[:beats]->(mh),
    (jj)-[:beats]->(bv),
    (bv)-[:beats]->(fm),
    (fm)-[:beats]->(bl),
    (nm)-[:beats]->(kg),
    (kg)-[:beats]->(mb),
    (mb)-[:beats]->(mh),
    (mb)-[:beats]->(kg),
    (mh)-[:beats]->(jj);

MATCH (n)
RETURN n LIMIT 25;

// To test Second Query
// CREATE
//     (f1:Fighter {name: 'Fighter 1',weight:'400'}),
//     (f2:Fighter {name: 'Fighter 2',weight:'400'}),
//     (f1)-[:beats]->(f2),
//     (f2)-[:beats]->(f1),
//     (f1)-[:beats]->(f2),
//     (f2)-[:beats]->(f1);


// Return all middle/Walter/light weight fighters (155,170,185) who at least have one win.
MATCH (Fighter) <- [:beats]-(n:Fighter) 
WHERE n.weight in ['155', '170', '185'] 
RETURN n LIMIT 25;

// Return fighters who had 1-1 record with each other. Use Count from the aggregation functions.
MATCH (a: Fighter)-[:beats]-> (b: Fighter)-[:beats]-> (a: Fighter)
WITH a, b, count(a) as r1, count(b) as r2 
WHERE r1=r2 AND r1=1 
RETURN a, b, r1, r2 LIMIT 25;

// Return all fighter that can “Khabib Nurmagomedov” beat them and he didn’t have a fight with them yet.
MATCH (a: Fighter {name: 'Khabib Nurmagomedov'})-[*2..]->(b:Fighter) 
RETURN b


// Return undefeated Fighters(0 loss), defeated fighter (0 wins).
MATCH (loser:Fighter), (winner:Fighter)
where not (loser:Fighter)-[:beats*1]->() AND NOT (winner:Fighter)<-[:beats*1]-() 
RETURN winner, loser


// Return all fighters MMA records and create query to enter the record as a property for a fighter {name, weight, record}.
MATCH (a:Fighter)-[:beats*1]-(b:Fighter)
WITH a, count(a) as n
SET a += {record: n}
RETURN a;