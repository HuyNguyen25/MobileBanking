/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  collection.name = "accounts"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("zp1lxr0ao7hi6my")

  collection.name = "users"

  return dao.saveCollection(collection)
})
