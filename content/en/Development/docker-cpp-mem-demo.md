---
author: "Cristian Mosquera"
title: "Docker Cpp Memory Demo"
date: 2020-05-30T18:11:25-04:00
lastmod: 2020-05-30T18:11:25-04:00
description: "Demonstration of mem analysis by C+++ Montreal - 2020"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- docker
- c++
- Memory analysis
---

# Memory analysis using docker 

- Reference: https://github.com/CppMtl/Meetups/tree/master/2020/2020-02-27%20%5BGabriel%20Aubut-Lussier%5D%20Memory%20analysis

## Roadmap

```bash
docker run --rm -it ubuntu
ls /proc
ls /proc/1
	bash
cat /proc/1/stack
docker run --privileged --rm -it ubuntu
cat /proc/1/stack
less /proc/1/smaps
apt-get install less
less /proc/1/maps
	Virtual memory
	Different binary sections
	Different permissions
	[heap]
	Shared libraries (libc, terminfo, dynamic linker)
	Anonymous zones
	[stack]
	[vvar], [vdso], [vsyscall]
less /proc/1/smaps
	Rss
	Pss
	Shared_*
	Private_*
	VmFlags
less /proc/1/smaps_rollup
less /proc/1/map_files/*
less /proc/1/oom_score
less /proc/1/status
	Vm*
pushd /home/01-programme-vide
	g++ main.cpp -o 01
	gdb 01
		break _exit
		run
	ps -a | grep 01
	less /proc/<pid>/maps
popd
pushd /home/02-programme-new
	g++ main.cpp -o 02
	gdb 02
		break _exit
		run
	ps -a | grep 02
	less /proc/<pid>/maps
	Arena
popd
pushd /home/03-gros-new
	g++ main.cpp -o 03 -g
	gdb 03
		break f
		run
		finish
	ps -a | grep 03
	less /proc/<pid>/maps
	Zone anonyme
popd
strace -e brk -k
strace -e mmap -k
```


## main-01.cpp

```cpp
int main()
{
        return 42;
}
```

## main-02.cpp

```cpp
int main()
{
        return *new int{42};
}
```

## main-03.cpp

```cpp
char* f()
{
        return new char[128*1024 - 15];
}

int main()
{
        f();
        return 42;
}
```

## main-04.cpp

```cpp
#include <vector>

void f()
{
        std::vector<std::vector<char>> v;
        const int n = 10;
        v.reserve(n);
        for (int i = 0; i < n; ++i) {
                v.emplace_back();
                v.back().reserve(127 * 1024);
        }
}

int main()
{
        std::vector<char> v;
        v.reserve(127*1024);
        f();
}
```