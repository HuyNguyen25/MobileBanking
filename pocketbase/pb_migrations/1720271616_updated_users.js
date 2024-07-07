/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  // remove
  collection.schema.removeField("chr3oadf")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "yzlnsfgi",
    "name": "contacts",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "zp1lxr0ao7hi6my",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": null,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "chr3oadf",
    "name": "contacts",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 2000000
    }
  }))

  // remove
  collection.schema.removeField("yzlnsfgi")

  return dao.saveCollection(collection)
})
