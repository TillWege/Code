# Praktikum

# Betriebssysteme und verteilte Systeme 22/23

### Installation

**Aufgabe:** Die erste Aufgabe besteht darin, Docker in Ihrer Ubuntu-Umgebung zu installieren. Dies geht über eine Folge von Kommandozeilenbefehlen, die hier zusammengestellt sind und in dieser Reihenfolge einzugeben sind. Sie sollten selbst recherchieren, wenn es Fehlermeldungen gibt oder Sie auf Hürden stoßen (z. B. Speicherplatzmangel, alte Version etc. Im Zweifel googeln Sie einfach "Docker installieren auf Ubuntu 22" o. ä.)

```
sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable'

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce
```

**Lösung:**
Docker installiert ✅

<div style="page-break-after: always;"></div>

### User berechten

Normale User dürfen Docker nicht verwenden. Um ständiges Arbeiten mit `sudo` zu verhindern, können Sie Ihren User zur Gruppe hinzufügen.

```
sudo usermod -aG docker ${USER} 
```

(wird bei nächster Anmeldung aktiv bzw. mit `su - ${USER}`)

### Verwendung

Die Syntax eines docker-Befehls ist so aufgebaut:

```
docker [option] [command] [arguments]
```

Eine Liste der Kommandos erhält man durch bloße Eingabe von `docker`.

### Images

Die einzelnen Docker-Container werden mithilfe aus Docker-Images erstellt. Diese ruft Docker vom globalen "Docker Hub" ab, wenn sie lokal nicht existieren.

Testen Sie den Erfolg Ihrer Installation mit dem einfachen Beispiel:

docker run hello-world

Das Image soll automatisch vom Hub geladen und lokal ausgeführt werden. Dabei soll u. a. folgende Ausgabe zu sehen sein.

```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

Die lokal vorhandenen Images können jederzeit per Befehl

```
docker images
```

angezeigt werden. Mit `docker ps` können laufende Container angezeigt werden, mit `docker ps -a` auch kürzlich beendete. Probieren Sie die Docker-Befehle selbstständig aus und suchen Sie nach Hilfen im Web, wenn die eingebaute Hilfe Ihnen nicht zusagt. Es gibt viele Beispiele und Ressourcen für Anfänger. Sie sollten in der Lage sein, Container zu beenden, Images wieder zu löschen und die nützlichen Namen (generierte Namen und hexadezimale Ziffernfolgen müssen nie vollständig eingegeben werden) zu verwenden.

<div style="page-break-after: always;"></div>

**Aufgabe:** Eine Interaktion mit einer Anwendung im Container ist möglich mit entsprechenden Schaltern (`-it`). Hier ein Beispiel eines Containers, der eine Bash enthält. Geben Sie ein paar Befehle in dieser Bash ein, um die Separierung von Ihrem Hostsystem zu überprüfen, erzeugen Sie ein paar Files (Sind diese persistent? Container einmal neustarten!) und vergleichen Sie die Bash-Versionsnummer mit ihrer sonst verwendeten Bash.


```
docker run -it --rm bash:4.4
```

Ein buntes (lustig gemeintes) Demo-Beispiel ist das folgende:

```
docker run -it --rm ghcr.io/pdevine/thisisfine
```

Mit der Interaktionstechnik können Sie auch Kommandozeilen ausführen, die nicht auf dem System installiert sind. Sie werden dann über Docker ggf. als Image heruntergeladen und als Container erzeugt und zur Ausführung gebracht. Das klingt zwar umständlich, geht aber so schnell, dass es in der Praxis nicht weiter stört. Beispiel-Kommando `whalesay` (inspiriert von `cowsay`)

```
docker run docker/whalesay cowsay Betriebssysteme
```

oder, wenn Sie etwas bunter haben möchten, `ponysay` (könnten Sie sonst auch als Binary für Ubuntu installieren), am besten mehrfach hintereinander ausführen, um die Variationen zu sehen:

```
docker run -ti --rm mpepping/ponysay "HSRW rulez!"
```

Die Aufgabe ist bearbeitet, wenn Sie die Kommandozeilenoptionen und die Separierung am Bash-Beispiel nachvollzogen haben. Stellen Sie dabei fest: Wann wird `-it` benötigt?

**Lösung:**
Mithilfe des Parameters `-it` wird die aktuelle Terminal-Session an die Ausgabe des Containers angehängt. Hierbei wird sowohl der Input, als auch der Output übernommen, bis der Container beendet wird.

**Erklärung:**
Das Dateisystem (und damit die gesammte Ausführungsumgebung) sind getrennt vom Ursprünglichen System. Das wird erkenntlich darduch, dass innerhalb des Containers andere Versionen der Tools verwendet werde.

<div style="page-break-after: always;"></div>

### Images herunterladen und konfigurieren

**Aufgabe:** Die nächste Aufgabe besteht nun darin, ein Docker-Image zu holen und lokal vorzuhalten. Wir nutzen dabei ein Image, das ein bekanntes Meme aufgreift und als vollständiges Webserversystem inklusive Content bereitstellt!

Herunterladen:

```
docker pull modem7/docker-rickroll
```

Ausführen:

```
docker run modem7/docker-rickroll
```

Inspizieren (ggf. neues Terminal aufmachen:

```
docker inspect (hex. Code eingeben bzw. c&p)
docker inspect hexCode | grep IP
```

Wir bemerken nun, dass das Image zwar läuft; wir können aber nicht auf den enthaltenen Webserver per Browser zugreifen, weil es keine erreichbare Adresse bzw. Port aufweist.

Stoppen bzw. entfernen Sie nun den laufenden Container. (Befehle dazu bitte selbst herausfinden.)

Mit der Option `-p` beim `docker run` können wir einen offenen Port mappen. Im Container ist der Server unter dem Port 8080 erreichbar wie die Info-Seite auf dem Hub ausweist: [https://hub.docker.com/r/modem7/docker-rickroll](https://hub.docker.com/r/modem7/docker-rickroll). Mappen Sie diesen auf einen freien Port (z. B. 80) und greifen Sie dann mit einem Browser auf den Server zu. (Nicht erschrecken und keine Sorge, der Ton ist ausgeschaltet bis Sie auf das Symbol klicken.) Beim Browser können Sie andere Ports als 80 (`http`) mit Doppelpunkt nach der URL angeben.

Die Aufgabe ist erfüllt, wenn die Animation im Browser zu sehen ist.

**Lösung:**
Rickroll wird angezeigt ✅

<div style="page-break-after: always;"></div>

### Weitere Images

**Aufgabe:**
Sehen Sie sich das Image `searx/searx` auf dem Hub an und bringen Sie es lokal als Container zur Ausführung (Metasuchmaschine, mit Browser zu nutzen). Ändern Sie die Datei `settings.yml` (mindestens eine Suchmaschine entfernen) und bringen Sie einen angepassten Container zur 
Ausführung.

**Lösung:**
Mit dem Befehl ``docker run --rm -d -v ${PWD}/searx:/etc/searx -p 80:8080 -e BASE_URL=http://localhost:80/ searx/searx`` lässt sich der Container so starten, dass die `settings.yml` Datei außerhalb des Containers persistiert wird. Nachdem innerhalb der `settings.yml` die einzelnen Search-Engines entfernt wurden, werden diese im Web-Interface nichtmehr angezeigt.

<div style="page-break-after: always;"></div>

**Aufgabe:**
Sehen Sie sich das Image `wettyoss/wetty` auf dem Hub an und bringen Sie es lokal als Container zur Ausführung (mit Browser zu nutzender Shellzugang zu Ihrem System).

**Lösung:**
Mit dem Befehl `docker run --rm -p 3000:3000 wettyoss/wetty --ssh-host=<YOUR-IP>` lässt sich der Wetty-Container starten. Über das Webinterface kann dann von außerhalb auf das Terminal des Containers zugegriffen werden.

<div style="page-break-after: always;"></div>

### Dockerfile erstellen

Die abschließende **Aufgabe** soll am Termin 5 von Ihnen präsentiert werden. Dazu sollen Sie selbst ein Dockerfile erstellen.

In einem Dockerfile werden die Anweisungen hinterlegt, die beim Erstellen des Images ausgeführt werden. Es ähnelt also einem Shellscript, allerdings gibt es ein vorgegebenes Format. Das Dockerfile definiert also das Image über eine schrittweise Erstellung, die auch Shellbefehle (werden mit `RUN` ausgeführt) beinhalten kann.

Hier ein einfaches Beispiel, das zur besseren Lesbarkeit per `\` einen Zeilenumbruch ermöglicht. Es wird per Dockerfile ein Java-Programm als Quellcode-Datei erzeugt, kompiliert und zur Ausführung gebracht. Erstellen Sie dazu ein Unterverzeichnis und darin eine Datei `Dockerfile` mit folgendem Inhalt:

---

```
FROM openjdk:8

WORKDIR /app

RUN echo "\
public class Main {\
public static void main(String[] args) {\
    System.out.println(\"Hallo Welt!\");\
    }\
}\
" > Main.java

RUN javac Main.java

ENTRYPOINT [ "java", "Main" ]
```

---

Anschließend wird mit

```
docker build -t javahallo .
```

das Image erstellt und mit

```
docker run javahallo
```

zur Ausführung gebracht. Bedenken Sie dabei, dass Sie keinen Java-Compiler auf Ihrem System installieren müssen; es wird einer im Container bereitgestellt. Das ist eine Folge der ersten Zeile des Dockerfiles.

Für die finale Aufgabe sollen Sie nun ein Dockerfile erstellen, mit dem ein Image erstellt wird, das in Abwandlung zur Aufgabe des vorherigen Teiltestats nicht einen Browser startet, um einen Text per HTML-Generierung auszugeben, sondern es soll ein Webserver gestartet werden, der diese generierte HTML-Seite ausliefert (sozusagen als "Startseite").

Beispielaufruf:

```
docker run -p 80:8080 infoterm "Amt geöffnet"
```

Nun kann ich den zentralen mittigen Text per Browser abrufen, indem ich `localhost` bzw. die IP-Adresse des Ubuntu-Systems, das Sie nutzen, eingebe. Die anderen `inforterm`-Funktionen aus dem vorherigen Praktikum müssen Sie nicht implementieren, es genügt die HTML-basierte Textausgabe per Webserver.

Sie können sich gerne von den Dockerfiles der Webserver-Beispiele inspirieren lassen, die Sie zuvor ausprobiert haben.

Beim Termin 5 sollen dann alle Container vorgeführt werden. Einen optionalen Ehrenpunkt gibt es für eine zusätzliche Soundausgabe.

**Lösung:**
Das Dockerfile verwendet das `httpd` Image. Bei diesem Image reicht es die passende HTML-Datei im ordner `/usr/local/apache2/htdocs/` abzulegen. Diese wird dann vom Webserver auf dem Port ausgeliefert. Mithilfe des Scriptes `infoterm` das passende HTML generiert und ausgeliefert.

Der mithilfe des Docker-file erstellte Container lässt sich (nach dem Builden) mit `docker run -d -p 80:80 infotermdocker "Testing"` starten