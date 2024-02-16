print('#################################################################');
print("Started Adding the Users.");
db = db.getSiblingDB("morningnews");
db.createUser( { user: "admin",  pwd: "admin", roles: [ { role: "clusterAdmin", db: "admin" },  { role: "readAnyDatabase", db: "admin" }, "readWrite"] });
db.createUser({user: "monitor",pwd: "monitor",roles: [{ role: "clusterMonitor", db: "admin" },{ role: "read", db: "local" }]})
print("End Adding the User Roles.");
print('#################################################################');