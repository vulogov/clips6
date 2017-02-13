# How To Work With the FACTS
---

Facts are the cornerstone of any expert system. They are representing the _"knowledge"_, based on which, you shall be able to make a decisions. In order to build successful Rule-Based Expert System, you shall know how to work with facts.

### How to get an access to the list of Facts ?

```python
import clips6

env = clips6.ENV()
facts = env.FACTS()
```
Now, the object _facts_ will provide you an access to the CLIPS _Facts_ capabilities.

### How to create (or in another word "assert") "The Fact"

Let's assume, that we do have a category of the facts called **'example'**  and this fact do have three slots. Fact slot is a representation of the part of the data from the fact. So, our **'example'** fact will have slots *'x'*, *'y'* and unnamed slot. In order to assert fact from the string, you do need t be aware of the CLIPS format for the knowledge representation. The this format is looks like:

```
(category-name (slot-name data) (slot-name data) ... data )
```

The Fact Definition (or *deftemplate*) is defined in file _./clips/test1.clp_. So, let's take a look at the example:

```python
import clips6

env = clips6.ENV()
env.LOAD('clips/test1.clp')
facts = env.FACTS()
fact1 = facts.ASSERT('(example (x 3) (y red) (z 1.5 b))')
```
Please note, before we are using the fact if the specific type, the proper *"deftemplate"* must be loaded into CLIPS environment.

Facts object asserting the fact from it's string representation by calling method _.ASSERT()_ which returns the reference on the single fact.

First, let's take a look what will happens, if we will try to use facts, without prior declaration of the proper template:

```python
>>> import clips6
>>> env = clips6.ENV()
>>> facts = env.FACTS()
>>> fact1 = facts.ASSERT('(example (x 3) (y red) (z 1.5 b))')

[EXPRNPSR3] Missing function declaration for x.
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "clips6_facts.pyx", line 111, in clips6.FACTS.ASSERT (/srv/shared/Src/clips6/src/clips6.c:13800)
    f.create(<void*>self.env, <void*>EnvAssertString(<void*>self.env, fact))
  File "clips6_facts.pyx", line 15, in clips6.FACT.create (/srv/shared/Src/clips6/src/clips6.c:11881)
    raise FactError, "FACT() not reaady in create()"
clips6.FactError: FACT() not reaady in create()
```
Two crutial pieces of information can bee seen here:

1. Message from the CLIPS Engine: **""EXPRNPSR3] Missing function declaration for x."**. This message clearly says that you are trying to use something which is not declared;
2. Exception from CLIPS of **clips6.FactError** clearly indicating that the fact was not created due to error.

But if you do load the proper **deftemplates**, everything will be allright.

```python
>>> print fact1
f-1     (example (v) (w 9) (x 3) (y red) (z 1.5 b) (answer) (abc 11))
```