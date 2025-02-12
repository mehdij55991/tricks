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


code cache
==========

inspect
-------
https://www.jasonpearson.dev/codecache-in-jvm-builds/
http://www.onemusicapi.com/blog/2021/01/13/understanding-code-cache-listing/
- jconsole
- jdk16+: jcmd <PID> Compiler.CodeHeap_Analytics
- jdk9+:  jcmd <PID> Compiler.codecache
          jcmd <PID> Compiler.Compiler.codelist
- jdk8:   +PrintCodeCache, +PrintCodeCacheOnCompilation

hot code heap
-------------
https://github.com/bell-sw/hotcode-agent/blob/master/results/performance.adoc
https://bugs.openjdk.org/browse/JDK-8328186


perf java jit code
==================
- install or build libperf-jvmti.so (source in linux/tools/perf)
- perf record -g -k 1 -- \
      java \
      -XX:+PreserveFramePointer \
      -agentpath:/usr/local/lib/libperf-jvmti.so \
      mytest
  * jit dump is saved to ~/.debug/jit/java-jit-xxxx
- perf inject --jit -i perf.data -o perf.data.jitted
- perf report --no-child -i perf.data.jitted --no-source


dump jit code
=============
- https://blogs.oracle.com/javamagazine/post/java-hotspot-hsdis-disassembler
- build or download hsdis plugin (https://chriswhocodes.com/hsdis/)
- LD_LIBRARY_PATH=/home/cyb/hsdis/ java \
      -XX:+UnlockDiagnosticVMOptions \
      -XX:CompileCommand=dontinline,*.arrayEquals \
      -XX:CompileCommand=print,*.arrayEquals \
      ArrayEqualsTest
- java -XX:CompileCommand=help


profile
=======
- [IMPORTANT] start profiled java process with
  "-XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints" to get more accurate
  information for inlined functions

- async profiler
  $ asprof -d 10 -f cpu.html `pgrep java`

  # seperate start/stop
  $ asprof start -i 997us `pgrep java`
  $ asprof stop -o flamegraph -f cpu.html `pgrep java`

  # separate threads
  $ asprof start -d 10 -t -f cpu-per-tid.html `pgrep java`

  # specify threads
  $ asprof -d 10 --filter 105703-105706,105710 -f cpu-per-tid.html `pgrep java`

  # wall clock (filter threads)
  $ asprof -e wall -d 10 --filter 105703-105706,105710 -f wall.html `pgrep java`


list vm flags
=============
- https://chriswhocodes.com/
- java -XX:+PrintFlagsFinal -version
- jcmd [pid] VM.flags
