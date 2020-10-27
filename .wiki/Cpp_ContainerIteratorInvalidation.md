# Iterator invalidation

## array

**All iterators to array elements remain valid in the lifetime of the array**

> after swap, iterators still point to original array memory location, so its value may change

## vector

- **All read-only operations**: Never
- **swap, std::swap**: only `end()`
- **clear, operator=, assign**: Everything
- **reserve, shrink_to_fit:** 
  - if change its capacity: Everything
  - else none
- **erase**: erased element and all elements after it(including `end()`)
- **push_back, emplace_back**: 
  - if change its capacity: Everything
  - else only `end()`
- **insert, emplace**:
  - if change its capacity: Everything
  - else insertion point and all elements after it (including `end()`)
- **resize**:
  - if change its capacity: Everything
  - else all erased elements and `end()`
- **pop_back**: erased element and `end()`

## list and associative containers(map,set...)

- **All inserting operations(insert, push_back...)**: Never
- **All erasing operations(erase, pop_back...)**: any erased elements