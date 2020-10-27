## 1. Single Responsibility Principle

## 2. Open/Closed 

## 3. Liskov Substitution

> 定义：假设f(x)是类型为 **T** 的对象 **X** 的固有属性，那么f(y)则应该是类型为 **S** 的对象 **Y **属性，其中 **S** 是 **T** 的子类
>
> *Let Φ(x) be a property provable about objects x of type T. Then Φ(y) should be true for objects y of type S where S is a subtype of T.*
>
> *Functions that use pointers or references to base classes must be able to use objects of*
> *derived classes without knowing it.*

### 解释

- 父类对象可被任何子类对象替换，且不会引起程序崩溃
- 对于虚函数，子类对入参的限制应小于等于父类（可接受比父类虚函数更广的参数范围）
- 对于虚函数，子类对返回值的限制应大于等于父类（返回值是父类虚函数返回类型本身或其子类）

### 举例

#### 正方形——长方形难题

- 首先定义**长方形类**

  ```c++
  class Rectangle {
  public:
      setHeight(int);
      setWidth(int);
      setEdges(int, int);
      getArea();
  private:
      height, width
  }
  ```

- 由于正方形是一种特殊的长方形，因此将正方形类定义为长方形类的子类

  ```c++
  class Square ： public class Rectangle {
  public：
      setHeight(int);
      setWidth(int);
      setEdges(int h, int w); // 依赖：h==w
      setEdge(int e);
      getArea();
  private：
      height, width // 依赖：h==w
  ```

- 若使用`Rectangle`指针创建`Square`对象并使用时，则可能打破依赖条件

  ```c++
  Rectangle* r = new Square();
  r->setEdges(10, 20);	// Error!, not a square
  ```

- 将`Square`类中和`Rectangle`类有关的方法禁用（如`setEdges`）—— 违反**里氏替换原则**，子类隐藏了父类的部分功能

#### 解决方法

`Square`是一种特殊的`Rectangle`，具有通常`Rectangle`所不具有的属性（例如长宽相等），因此 `Square`不是`Rectangle`的子类，需要用**组合**的方式来构造`Square`

```c++
class Square {
public:
    setEdge(int e) {
        iml.setEdges(e, e);
    }
    getArea(){
        iml.getArea();
    }
    ...
private:
    Rectangle iml;
}
```

## 4. Interface Segregation 

## 5. Dependency Inversion

