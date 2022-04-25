from pymongo import MongoClient



def delete_items(db):
    res = db.restaurants.delete_one({"borough": "Manhattan"})
    res2 = db.restaurants.delete_many({"cuisines": "Thai"})
    return [res, res2]


if __name__ == '__main__':
    client = MongoClient("mongodb+srv://root:12345@cluster0.7lp7d.mongodb.net/test?retryWrites=true&w=majority")
    db = client['test']
    print(delete_items(db))