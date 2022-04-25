from pymongo import MongoClient


def task_1(db):
    cursor = db.restaurants.find({"cuisine": "Indian"})
    return {
        "total": len(list(cursor)),
        "data": list(cursor)
    }


def task_2(db):
    cursor1 = db.restaurants.find({"cuisine": "Indian"})
    cursor2 = db.restaurants.find({"cuisine": "Thai"})
    return {
        "total": len(list(cursor1)) + len((list(cursor2))),
        "data": list(cursor1).extend(list(cursor2))
    }


def task_3(db):
    cursor = db.restaurants.find({"address": {"building": "1115", "street": "Rogers Avenue", "zipcode": "11226"}})
    return {
        "total": len(list(cursor)),
        "data": list(cursor)
    }


if __name__ == '__main__':
    client = MongoClient("mongodb+srv://root:12345@cluster0.7lp7d.mongodb.net/test?retryWrites=true&w=majority")
    db = client['test']
    print(f"Ex1[Task 1]: Total: {task_1(db)['total']}")
    print(f"Ex1[Task 2]: Total: {task_2(db)['total']}")
    print(f"Ex1[Task 3]: Total: {task_3(db)['total']}")
