/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  // remove
  collection.schema.removeField("ncwkxb07")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ncwkxb07",
    "name": "account_id",
    "type": "text",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "min": null,
      "max": null,
      "pattern": ""
    }
  }))

  return dao.saveCollection(collection)
})
