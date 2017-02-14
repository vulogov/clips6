# How To Work With the FACTS

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

### How to get the list of the FACT's

You've asserted a bunch of facts. Maybe your Rules were also responcible for some of those, now you do need to have an access to the list of the FACT's known to CLIPS.

There is a method *.FACTS()* of the *facts* object. This method returned the list of the instances of type *FACT()*

```python
import clips6
env = clips6.ENV()
env.LOAD('clips/test1.clp')
facts = env.FACTS()
facts.ASSERT('(example (x 3) (y red) (z 1.5 b))')
for fact in facts.FACTS():
    print fact
```

The output of this code shall lokks like this:

```python
f-0     (initial-fact)
f-1     (example (v) (w 9) (x 3) (y red) (z 1.5 b) (answer) (abc 11))
```

Please note, the *(initial-fact)* is created by the CLIPS during initialization. Please refer to the CLIPS documentation for more details.

### How to work with FACT slots, or reading data from the FACT.

The fact would be completely useless for us, unless we can access it's content. **clips6** provides you the API similar to the Python dictionary.

Here is how you can access the list of the fact slots:

```python
import clips6
env = clips6.ENV()
env.LOAD('clips/test1.clp')
facts = env.FACTS()
fact1 = facts.ASSERT('(example (x 3) (y red) (z 1.5 b))')
print fact1.KEYS()
```

The output of this code snippet will be 

```python
['v', 'w', 'x', 'y', 'z', 'answer', 'abc']
```

Which is matched to the slots that we are set during assertion

```python
(example (x 3) (y red) (z 1.5 b))
```

And the list of the slots defined in *deftemplate example*

```python
(deftemplate example
    (multislot v)
    (slot w (default 9))
    (slot x)
    (slot y)
    (multislot z)
    (multislot answer)
    (slot abc (default 11))
)
```

Which are: "v", "w", "x", "y", "z", "ansewer", "abc"

Next, let me show you how to access the slot value:

```python
value = fact1["x"]
print value
```

The output will be very predictable and equal to _3_

### What about IMPLIED Fact's ?

clips6 support that too. First, let's assert implied fact:

```python
import clips6
env = clips6.ENV()
env.LOAD('clips/test1.clp')
facts = env.FACTS()
fact1 = facts.ASSERT('(hello world)')
print "Is the fact1 Implied ?",fact1.IS_IMPLIED()
```

We just assert the fact of _implied_ deftemplate "hello", please note, we don't have to define that template. Also, please note, there is no slots in implied facts. The output of this snippet is predictably **Is the fact1 Implied ? True**

Now, let's look, how we can access _implied_ fact data:

```python
print fact1.IMPLIED()
```

The output, as we expected, will be 

```python
['world']
```