name := "postgres-squeryl-class-generator example"

version := "0.1"

scalaVersion := "2.9.2"

libraryDependencies  ++=  Seq(
  "org.squeryl" %% "squeryl" % "0.9.5-6",
  "postgresql" % "postgresql" % "8.4-701.jdbc4",
  //"org.xerial" % "sqlite-jdbc" % "3.7.2",
  "org.wisdom-framework" % "sqlite-jdbc" % "3.8.7_1",
  "mysql" % "mysql-connector-java" % "5.1.10"
)

seq(com.github.retronym.SbtOneJar.oneJarSettings: _*)
