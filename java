create jar from classes
=======================
$ pwd
path/to/classes/

$ tree
.
└── com
    └── example
        ├── MyClass.class
        └── AnotherClass.class

$ jar cf my-classes.jar -C path/to/classes/ .

$ jar tf my-classes.jar
com/
com/example/
com/example/MyClass.class
com/example/AnotherClass.class


install jar manualy for mvn project
===================================
$ mvn install:install-file \
      -Dfile=./com.taobao.hsf.com.caucho.hessian.jar \
      -DgroupId=com.taobao.hsf.hessian \
      -DartifactId=hessian \
      -Dversion=4.0.7.bugfix12-tuning3 \
      -Dpackaging=jar

$ cat pom.xml
...
<dependency>
    <groupId>com.taobao.hsf.hessian</groupId>
    <artifactId>hessian</artifactId>
    <version>4.0.7.bugfix12-tuning3</version>
</dependency>
...

$ cat DubboClient.java
...
import com.alibaba.com.caucho.hessian.io.SerializerFactory;
...
