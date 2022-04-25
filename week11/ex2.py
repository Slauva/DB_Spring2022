from pymongo import MongoClient


def insert_data(db):
    result = db.restaurants.insert_one({
        "_id": "41704620",
        "address": {
            "building": "1480",
            "coord": ["-73.9557413", "40.7720266"],
            "street": "2 Avenue",
            "zipcode": "10075",
        },
        "borough": "Manhattan",
        "cuisine": "Italian",
        "name": "Vella",
        "grades": [{
            "date": "01 Oct, 2014",
            "grades": "A",
            "score": 11
        }]
    })
    return result


if __name__ == '__main__':
    client = MongoClient("mongodb+srv://root:12345@cluster0.7lp7d.mongodb.net/test?retryWrites=true&w=majority")
    db = client['test']
    print(insert_data(db))
