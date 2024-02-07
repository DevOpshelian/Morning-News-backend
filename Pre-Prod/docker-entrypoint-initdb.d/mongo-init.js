print('#################################################################');
print("Started Adding the Users.");
db = db.getSiblingDB("morningnews");
db.createUser( { user: "admin",  pwd: "admin", roles: [ { role: "clusterAdmin", db: "admin" },  { role: "readAnyDatabase", db: "admin" }, "readWrite"] });
print("End Adding the User Roles.");
print('#################################################################');