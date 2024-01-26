
### show dbs

```bash
show dbs
```
### show collections

collections like table in rdbms

```bash
show collections
```

- 기본적으로 없을 경우 자동생성한다.


## query

### insertOne

```bash

db.users.insertOne({name: John})

```

### find

- 조건을 안걸면 모든유저가 나온다.
- 한글입력:

```bash

db.users.find()

```
