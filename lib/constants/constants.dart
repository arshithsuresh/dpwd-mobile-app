const String GOVT_ORG = "GovtOrg";
const String PUBLIC_ORG = "PublicOrg";
const String CONTRACTOR_ORG = "ContractorOrg";

const Map<String, int> UpdateType = {
  "Progress Update": 0,
  "Budget Update": 1,
  "Update Agreement": 2,
  "Update Billed Amount": 3,
  "Update Sanctioned Amount": 4
};

const List<String> ComplaintType = [
  "Poth Hole",
  "Side Walk",
  "Road Cracks",
  "Hazardous Hump",
  "Water Loggin",
  "Footpath Damaged"
];

const Map<int, String> ComplaintStatus = {
  0: "Pending Verification",
  1: "Verified",
  4: "In Progress",
  2: "Resolved",
  3: "Invalid"
};
