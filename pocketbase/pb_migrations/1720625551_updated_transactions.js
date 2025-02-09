/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vzgd1hedcct7uqx")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "hqaucxpd",
    "name": "amount_of_money",
    "type": "number",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "noDecimal": false
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("vzgd1hedcct7uqx")

  // remove
  collection.schema.removeField("hqaucxpd")

  return dao.saveCollection(collection)
})
