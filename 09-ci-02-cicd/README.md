# Домашнее задание к занятию "09.02 CI\CD"

## Знакомоство с SonarQube

### Основная часть

![image](https://user-images.githubusercontent.com/26147777/179748179-9590078d-ac37-4281-9933-480585e79873.png)

## Знакомство с Nexus

### Подготовка к выполнению

![image](https://user-images.githubusercontent.com/26147777/179761440-8f11fe13-cde6-446f-b7e1-a1fd5704ccf1.png)
```
<metadata modelVersion="1.1.0">
<groupId>netology</groupId>
<artifactId>java</artifactId>
<versioning>
<latest>8_282</latest>
<release>8_282</release>
<versions>
<version>8_102</version>
<version>8_282</version>
</versions>
<lastUpdated>20220719132432</lastUpdated>
</versioning>
</metadata>
```

### Знакомство с Maven

```
 ras@ras-VirtualBox  /opt/maven/apache-maven-3.8.6/bin  ls -lha ~/.m2/repository/netology/java/8_282/
итого 24K
drwxrwxr-x 2 ras ras 4,0K июл 19 17:03 .
drwxrwxr-x 3 ras ras 4,0K июл 19 17:03 ..
-rw-rw-r-- 1 ras ras  802 июл 19 17:03 java-8_282-distrib.tar.gz
-rw-rw-r-- 1 ras ras   40 июл 19 17:03 java-8_282-distrib.tar.gz.sha1
-rw-rw-r-- 1 ras ras  386 июл 19 17:03 java-8_282.pom.lastUpdated
-rw-rw-r-- 1 ras ras  175 июл 19 17:03 _remote.repositories
 ras@ras-VirtualBox  /opt/maven/apache-maven-3.8.6/bin  


```

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.netology.app</groupId>
  <artifactId>simple-app</artifactId>
  <version>1.0-SNAPSHOT</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-public</name>
      <url>http://localhost:8081/repository/maven-releases/</url>
    </repository>
  </repositories>
  <dependencies>
     <dependency>
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <version>8_282</version>
      <classifier>distrib</classifier>
      <type>tar.gz</type>
    </dependency>
  </dependencies>
</project>
```

