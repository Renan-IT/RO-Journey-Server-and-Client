1. Go to the path -> db/import
2. Add in item_randomopt_db.yml:

```
Footer:
  Imports:
  - Path: db/pre-re/item_randomopt_db.yml
    Mode: Prerenewal
  - Path: db/re/item_randomopt_db.yml
    Mode: Renewal
  - Path: db/import/item_randomopt_db.yml
```
1.2 Add in item_randomopt_group.yml:
```
Footer:
  Imports:
  - Path: db/pre-re/item_randomopt_group.yml
    Mode: Prerenewal
  - Path: db/re/item_randomopt_group.yml
    Mode: Renewal
  - Path: db/import/item_randomopt_group.yml
```
2. Go to the path -> db/re
3. Copy item_randomopt_group.yml and item_randomopt_db.yml
4. Add both files in db/pre-re
`cp db/re/{item_randomopt_group.yml,item_randomopt_db.yml} db/pre-re/`
