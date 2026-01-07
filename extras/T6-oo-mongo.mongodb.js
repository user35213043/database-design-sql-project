// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T6-oo-mongo.mongodb.js

// Student ID: 35213043
// Student Name: George Gabriel Widjaja
// ====================================================================================
// DO NOT modify or relocate any of the comments below (items marked with //)
// You are required to add additional comments as described on page five of this brief.
// ====================================================================================

// Use (connect to) your database - you MUST update xyz001
// with your authcate username

use("gwid0006");

// (b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your statement is formatted and has a semicolon
// (;) at the end of each MongoDB statement

// Drop collection
const collName = "oo_passengers";
db.getCollection(collName).drop();

// Create collection and insert documents
db.createCollection(collName);


// List all documents you added
db.getCollection(collName).insertMany([
    {"_id":1,"passenger_name":"Liam Hughes","passenger_dob":"12-Mar-1988","passenger_contact":"0400000001","guardian_name":"-","address":{"street":"10 Collins St","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:30","ship_code":101,"cabin_no":"1001"},{"cruise_id":9,"cruise_name":"Queensland Islands","board_datetime":"-","ship_code":101,"cabin_no":"1012"}]},
    {"_id":2,"passenger_name":"Sofia Hughes","passenger_dob":"02-Jul-1990","passenger_contact":"0400000002","guardian_name":"-","address":{"street":"10 Collins St","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:30","ship_code":101,"cabin_no":"1002"},{"cruise_id":9,"cruise_name":"Queensland Islands","board_datetime":"-","ship_code":101,"cabin_no":"1013"}]},
    {"_id":3,"passenger_name":"Noah Kumar","passenger_dob":"01-Nov-1979","passenger_contact":"0400000003","guardian_name":"-","address":{"street":"88 Swanston Ave","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":2,"cruise_name":"Melbourne to Sydney","board_datetime":"16-Jun-2025 08:30","ship_code":102,"cabin_no":"2001"},{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:50","ship_code":101,"cabin_no":"1003"}]},
    {"_id":4,"passenger_name":"Ava Kumar","passenger_dob":"15-Jan-1981","passenger_contact":"0400000004","guardian_name":"-","address":{"street":"88 Swanston Ave","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":2,"cruise_name":"Melbourne to Sydney","board_datetime":"16-Jun-2025 08:30","ship_code":102,"cabin_no":"2002"},{"cruise_id":3,"cruise_name":"New Zealand Delight","board_datetime":"16-Jun-2025 08:50","ship_code":103,"cabin_no":"211"}]},
    {"_id":5,"passenger_name":"Oliver Ng","passenger_dob":"20-May-1992","passenger_contact":"0400000005","guardian_name":"-","address":{"street":"25 Queen St","town":"Auckland","postcode":"1010","country":"New Zealand"},"no_of_cruises":1,"cruises":[{"cruise_id":3,"cruise_name":"New Zealand Delight","board_datetime":"16-Jun-2025 08:40","ship_code":103,"cabin_no":"110"}]},
    {"_id":6,"passenger_name":"Mia Tan","passenger_dob":"10-Feb-1995","passenger_contact":"0400000006","guardian_name":"-","address":{"street":"5 Marina Bay","town":"Singapore","postcode":"018940","country":"Singapore"},"no_of_cruises":1,"cruises":[{"cruise_id":3,"cruise_name":"New Zealand Delight","board_datetime":"16-Jun-2025 08:45","ship_code":103,"cabin_no":"111"}]},
    {"_id":7,"passenger_name":"Lucas Smith","passenger_dob":"08-Aug-1987","passenger_contact":"0400000007","guardian_name":"-","address":{"street":"120 George St","town":"Sydney","postcode":"2000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":7,"cruise_name":"Melbourne to Auckland","board_datetime":"23-Oct-2025 14:30","ship_code":103,"cabin_no":"112"}]},
    {"_id":8,"passenger_name":"Emily Smith","passenger_dob":"09-Sep-1989","passenger_contact":"0400000008","guardian_name":"-","address":{"street":"120 George St","town":"Sydney","postcode":"2000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:55","ship_code":101,"cabin_no":"1004"},{"cruise_id":7,"cruise_name":"Melbourne to Auckland","board_datetime":"23-Oct-2025 14:30","ship_code":103,"cabin_no":"113"}]},
    {"_id":9,"passenger_name":"Aria Lim","passenger_dob":"30-Dec-1984","passenger_contact":"0400000009","guardian_name":"-","address":{"street":"9 Orchard Rd","town":"Singapore","postcode":"238802","country":"Singapore"},"no_of_cruises":1,"cruises":[{"cruise_id":8,"cruise_name":"Melbourne to Singapore","board_datetime":"-","ship_code":105,"cabin_no":"8031"}]},
    {"_id":10,"passenger_name":"James Wijaya","passenger_dob":"04-Apr-1983","passenger_contact":"0400000010","guardian_name":"-","address":{"street":"17 Jalan Sudirman","town":"Jakarta","postcode":"10270","country":"Indonesia"},"no_of_cruises":1,"cruises":[{"cruise_id":8,"cruise_name":"Melbourne to Singapore","board_datetime":"-","ship_code":105,"cabin_no":"8032"}]},
    {"_id":11,"passenger_name":"Grace Wijaya","passenger_dob":"06-Jun-1986","passenger_contact":"0400000011","guardian_name":"-","address":{"street":"17 Jalan Sudirman","town":"Jakarta","postcode":"10270","country":"Indonesia"},"no_of_cruises":1,"cruises":[{"cruise_id":5,"cruise_name":"Brisbane to Hobart","board_datetime":"08-Jul-2025 10:00","ship_code":102,"cabin_no":"2003"}]},
    {"_id":12,"passenger_name":"Ethan Lee","passenger_dob":"01-Jan-1991","passenger_contact":"0400000012","guardian_name":"-","address":{"street":"42 Queen St","town":"Brisbane","postcode":"4000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":1,"cruise_name":"Australian Circumnavigation","board_datetime":"02-Jun-2025 09:10","ship_code":101,"cabin_no":"2001"}]},
    {"_id":13,"passenger_name":"Chloe Lee","passenger_dob":"10-Oct-1993","passenger_contact":"0400000013","guardian_name":"-","address":{"street":"42 Queen St","town":"Brisbane","postcode":"4000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":1,"cruise_name":"Australian Circumnavigation","board_datetime":"02-Jun-2025 09:10","ship_code":101,"cabin_no":"2002"}]},
    {"_id":14,"passenger_name":"Benjamin Park","passenger_dob":"02-Feb-1982","passenger_contact":"0400000014","guardian_name":"-","address":{"street":"11 Queen St","town":"Auckland","postcode":"1010","country":"New Zealand"},"no_of_cruises":1,"cruises":[{"cruise_id":1,"cruise_name":"Australian Circumnavigation","board_datetime":"02-Jun-2025 09:15","ship_code":101,"cabin_no":"2003"}]},
    {"_id":15,"passenger_name":"Isla Park","passenger_dob":"03-Mar-1984","passenger_contact":"0400000015","guardian_name":"-","address":{"street":"11 Queen St","town":"Auckland","postcode":"1010","country":"New Zealand"},"no_of_cruises":1,"cruises":[{"cruise_id":7,"cruise_name":"Melbourne to Auckland","board_datetime":"23-Oct-2025 14:45","ship_code":103,"cabin_no":"213"}]},
    {"_id":16,"passenger_name":"Jack Hughes","passenger_dob":"12-Jul-2011","passenger_contact":"-","guardian_name":"Liam Hughes","address":{"street":"10 Collins St","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":2,"cruises":[{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:40","ship_code":101,"cabin_no":"1011"},{"cruise_id":9,"cruise_name":"Queensland Islands","board_datetime":"-","ship_code":101,"cabin_no":"1011"}]},
    {"_id":17,"passenger_name":"Ella Hughes","passenger_dob":"22-Nov-2013","passenger_contact":"-","guardian_name":"Sofia Hughes","address":{"street":"10 Collins St","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":4,"cruise_name":"Queensland Islands","board_datetime":"07-Jul-2025 13:40","ship_code":101,"cabin_no":"1011"}]},
    {"_id":18,"passenger_name":"Harper Kumar","passenger_dob":"05-May-2010","passenger_contact":"-","guardian_name":"Noah Kumar","address":{"street":"88 Swanston Ave","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":2,"cruise_name":"Melbourne to Sydney","board_datetime":"16-Jun-2025 08:40","ship_code":102,"cabin_no":"2011"}]},
    {"_id":19,"passenger_name":"Leo Smith","passenger_dob":"09-Sep-2009","passenger_contact":"-","guardian_name":"Lucas Smith","address":{"street":"120 George St","town":"Sydney","postcode":"2000","country":"Australia"},"no_of_cruises":1,"cruises":[{"cruise_id":7,"cruise_name":"Melbourne to Auckland","board_datetime":"23-Oct-2025 14:40","ship_code":103,"cabin_no":"114"}]},
    {"_id":20,"passenger_name":"Mason Wijaya","passenger_dob":"12-Dec-2012","passenger_contact":"-","guardian_name":"James Wijaya","address":{"street":"17 Jalan Sudirman","town":"Jakarta","postcode":"10270","country":"Indonesia"},"no_of_cruises":1,"cruises":[{"cruise_id":8,"cruise_name":"Melbourne to Singapore","board_datetime":"-","ship_code":105,"cabin_no":"8033"}]},
    {"_id":21,"passenger_name":"Olivia Hart","passenger_dob":"09-Sep-1998","passenger_contact":"0400000021","guardian_name":"-","address":{"street":"42 Queen St","town":"Brisbane","postcode":"4000","country":"Australia"},"no_of_cruises":0,"cruises":null},
    {"_id":500,"passenger_name":"Dominik Kohl","passenger_dob":"10-May-1985","passenger_contact":"+61493336312","guardian_name":"-","address":{"street":"23 Banksia Avenue","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":0,"cruises":null},
    {"_id":505,"passenger_name":"Stella Kohl","passenger_dob":"15-Aug-2010","passenger_contact":"-","guardian_name":"Dominik Kohl","address":{"street":"23 Banksia Avenue","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":0,"cruises":null},
    {"_id":510,"passenger_name":"Poppy Kohl","passenger_dob":"25-Sep-2012","passenger_contact":"-","guardian_name":"Dominik Kohl","address":{"street":"23 Banksia Avenue","town":"Melbourne","postcode":"3000","country":"Australia"},"no_of_cruises":0,"cruises":null}
]);

// List all documents you added (short view) 
db.getCollection(collName)
  .find({}, { _id: 1, passenger_name: 1, no_of_cruises: 1 })
  .sort({ _id: 1 })
  .pretty();


// (c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Passengers who live in Australia or New Zealand AND have booked > 2 cruises
// Shows: id, name, contact, full address
db.getCollection(collName)
  .find(
    {
      "address.country": { $in: ["Australia", "New Zealand"] },
      // If you prefer to trust the stored count:
      // no_of_cruises: { $gt: 2 }
      // …or compute from the array size to be robust:
      $expr: { $gt: [{ $size: { $ifNull: ["$cruises", []] } }, 2] }
    },
    {
      _id: 1,
      passenger_name: 1,
      passenger_contact: 1,
      address: 1
    }
  )
  .sort({ _id: 1 })
  .pretty();

// (d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your statement is formatted and has a semicolon
// (;) at the end of each MongoDB statement


// (i) Add new passenger and first booking
db.getCollection(collName).updateOne(
  { _id: 1000 },
  {
    $setOnInsert: {
      passenger_name: "Kiera Meier",
      passenger_dob: "-",
      passenger_contact: "-",
      guardian_name: "-",
      address: { street: "-", town: "-", postcode: "-", country: "Australia" }
    },
    $set: {
      // first booking for cruise id 9 (Queensland Islands), Balcony cabin 2022
      no_of_cruises: 1,
      cruises: [
        {
          cruise_id: 9,
          cruise_name: "Queensland Islands",
          board_datetime: "-",
          ship_code: 101,         // use the real code if required by your data
          cabin_no: "2022",
          cabin_class: "Balcony"
        }
      ]
    }
  },
  { upsert: true }
);

// ---- Illustrate/confirm changes made
db.getCollection(collName)
  .find({ _id: 1000 }, { _id: 1, passenger_name: 1, no_of_cruises: 1, cruises: 1 })
  .pretty();


// (ii) Add second booking
// Cruise id 10: New Zealand Christmas Sail, Suite cabin 4004
db.getCollection(collName).updateOne(
  { _id: 1000 },
  {
    $push: {
      cruises: {
        cruise_id: 10,
        cruise_name: "New Zealand Christmas Sail",
        board_datetime: "-",
        ship_code: 103,       // use the real code if required by your data
        cabin_no: "4004",
        cabin_class: "Suite"
      }
    },
    $inc: { no_of_cruises: 1 }
  }
);


// Illustrate/confirm changes made
db.getCollection(collName)
  .find({ _id: 1000 }, { _id: 1, passenger_name: 1, no_of_cruises: 1, cruises: 1 })
  .pretty();


/* (iii) Write a reflection of the difference
between inserting the passenger and booking data
into the Oracle versus MongoDB.

<<write your reflection here>>

Oracle had several related tables (PASSENGER, MANIFEST, CABIN, CRUISE),
keys, and foreign-key checks, it follows that inserts had to follow order and integrity.
(e.g. add parent rows then child rows). The process was verbose but
guaranteed consistency, and types/constraints imposed structure.

MongoDB has enabled us to create a passenger and his or her bookings in one document using an.
embedded array. A single upsert with a push was added to Kiera + bookings.
and there is no need to create parent records in advance, or do joins. It's faster to evolve
and quite user-friendly on passenger-focused queries. The trade-off is that data
integrity application-driven: no foreign key, thus inconsistent ID.
or gilted ciphers are a matter of chance unless the application is on its guard. In short, Oracle is
schema-first and strongly consistent; MongoDB schema- flexible and convenient.
on nested, aggregate documents, yet transfers responsibility on relational.
Limitations to the application.

*/