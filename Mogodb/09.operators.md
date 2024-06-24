
## Comparison Operators

- `$eq`
- `$ne`
- `$gt`
- `$gte`
- `$lt`
- `$lte`
- `$in`
- `$nin`

```javascript
db.products.find({ 'price': { $eq: 699 } });
db.category.find({ price: { $in: [249, 129, 39] } });
```


## Logical Operators

- `$and`
- `$or`
- `$not`
- `$nor`

```javascript
{ $and: [ { condition1 }, { condition2 }, /* ... */ ] }
{ field: { $not: { operator: value } } }
```

### $or Operators

#### Result

```javascript
{ $or: [ { condition1 }, { condition2 }, /* ... */ ] }
```

Example
```javascript
db.products.find({ $expr: { $gt: ['$price', 1340] } });
```

## Elements Operator
- $exists
- $type
- $size

```javascript
{ field: { $exists: <boolean> } }
{ field: { $type: "<bson-data-type>" } }
{ field: { $size: <array-length> } }
```