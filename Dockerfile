FROM ubuntu:22.04

WORKDIR /workspace

RUN apt update

RUN apt install -y openjdk-17-jdk

WORKDIR /code

COPY bin .

RUN echo "Main-Class: example.Main" > manifest.mf

RUN javac $(find src -type f -name "*.java")

RUN cp -R src/main/java/* .

RUN jar cfm Main.jar manifest.mf example

RUN jlink --add-modules $(jdeps --list-reduced-deps Main.jar) --output /code/jre

CMD ["/code/jre/bin/java", "-jar", "Main.jar"]