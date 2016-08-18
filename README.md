# publictransport-applet
A Plasma5/Qml applet that displays timetable data fetched from the publictransport dataengine in a list view format

## Brief History
The publictransport applet, in KDE4, had two distinct types of service providers:

1. Scripted type service providers
2. General Transit Feed Specification(GTFS) type service providers

The service providers provide public transport timetable data, like stops from A to B, or a list
of arrivals/departures at particular stop along with the departure date/time. This data was 
displayed in a neat Plasma applet in KDE4 along with features like adding an alarm for transport,
autocompletion of stop names and displaying mete data like stops in a journey and more. 

[Know more about the KDE4 Plasma public transport applet](http://fpuelz-kde.blogspot.in/2011/10/plasma-publictransport.html)

## Current works
During this summer, efforts were made to bring back this applet to Plasma5. This however, was not
a straightforward task as applets in Plasma5 are primarily written in Qml and a port of the applet
meant a complete re-write of the UI.
Obviously, the public transport dataengine also needed porting to KF5. The dataengine returned
`QVariantHash` data which is not consumable by Qml. Hence the engine had to be ported away from 
`QVariantHash` to `QVariantMap`.

In it's current state, the public transport dataengine provides the possibility to 

1. Discover local service provider files(.pts file format)
2. Carry out GTFS service operations, viz
    * GTFS database import
    * GTFS feed update
    * GTFS database update
    * GTFS database deletion

Once installed, the public transport dataengine can be accessed via `plasmaengineexplorer`
```
    $ plasmaengineexplorer --engine publictransport
```

Scripted type service providers in KDE4, relied upon `QtScript` to parse feeds to retrieve timetable data.
However, `QtScript` was deprecated in Qt's 5.5 release without a direct alternative and hence such
service providers won't function in a KF5 setup, as we can now no longer pass Qt extensions to 
`QScriptEngine`.

This meant either writing a C++ class to provide support for scripted service providers or to
completely switch to GTFS type service providers. 

At this point, it is both easier and sensible to switch to using GTFS type service providers in
KF5 as GTFS specifies a common standard for the data, making it easier to handle.

## Dependencies
* [publictransport dataengine](https://quickgit.kde.org/?p=clones%2Fpublictransport%2Frharishnavnit%2Fpublictransport-frameworks.git) - "kf5" branch
* GTFS Service providers

## How to get a GTFS service provider for my location ?
You can download GTFS service providers from [KDE Look](http://kdelook.org/index.php?xcontentmode=638).
Currently, the page at [KDE Look](http://kdelook.org/index.php?xcontentmode=638) also displays scripted
type service providers which are still useful in a KDE4 session and hence not removed. Be sure to see if
the service provider you've downloaded is a GTFS type service provider. This can be easily verified in
`plasmaengineexplorer`. 

## Adding new service providers
If you are unable to find a service provider for your location, you can add a service provider of your own.
Modify the relevant XML tags of this [example GTFS service provider file](./no_ruter.pts) and place it in the engine's
**installation subdirectory**.

### Naming conventions for newly added service providers
The public transport dataengine recognizes service provider files with "__.pts__" extensions.
The filename without the extension forms your service provider Id. So it is important to name
your service provider filename correctly.
As a rule of thumb, service provider Id's follow the following format
```
    <country_shortcode>_<agency/provider>.<extension>
```
Hence, for example, a service provider for Oslo, in Norway provided by Ruter Inc. would be named as
`no_ruter.pts` and `no_ruter` becomes the service provider Id. Use lower case characters in naming
your service provider file.

## Creating an arrival/departure source
To view departures and/or arrivals, we must first create a datasource in the dataengine.
The general format of an arrival or departure source is as follows :
```
    Departures <serviceProviderId>|stop=<stopName>
```
or
```
    Arrivals <serviceProviderId>|stop=<stopName>
```
A departure source for eg, would look like the following 
```
    Departures no_ruter|stop=Oslo Bussterminal
```
Where `serviceProviderId` = `no_ruter` and `stopName` = `Oslo Bussterminal`.
Once you know the `serviceProviderId` and `stopName`, in `plasmaengineexplorer`, type your source name
in the field with placeholder "Source Name" and request for the source.

*Please note that the source names are __case-sensitive__ and this must be taken into consideration when forming
a new datasource.*

## Setting up a service provider for the dataengine
As things stand, service providers for the public transport dataengine have to be configured manually.
Configuration UI is WIP and it's current state can be found in this repository itself. The UI is, as one
would expect, being written in Qml. 

Untill the configuration UI's are ready, to configure service providers, you must do the following:

1. Create a directory `plasma_engine_publictransport/serviceProviders` inside `~/.local/share` and move
your downloaded service provider file inside it. This is your *installation subdirectory*
2. Launch `plasmaengineexplorer` and check if your service provider is discovered correctly.
3. Start the "GTFS" service
    * Type "GTFS" in the field with placeholder "Service for source" and start a request.
4. Now select the "importGtfsFeed" operation and enter the service provider Id in the value field.
    * Service provider Id is the name of your service provider filename, without the extensions(.pts)
5. Once the GTFS feed is imported successfully, relaunch `plasmaengineexplorer` and test for an arrival
or departure source

You should now be able to view departure or arrival details, depending on your source in the dataengine.

## Viewing departure/arrival details in the applet
Once you have setup and tested that your service provider works flawlessly in `plasmaengineexplorer` with
your datasource, you are ready to view this in data in your applet. 
In file `timetable/contents/ui/Timetable.qml`, replace the value of `connectedSources` with that of your 
arrival/departure datasource name.

Install and launch the applet to view timetable data for the stop of your choice.

## Installing the applet
```
    $ cmake -DCMAKE_INSTALL_PREFIX=/your/custom/install/prefix ..
    $ make install
    $ kbuildsycoca5
```
It is recommended that you install this applet, which currently needs testing, in a custom non-root prefix.

## Launching the applet
You can launch the applet using `plasmawindowed` or add it as a widget from your desktop.
```
    $ plasmawindowed org.kde.plasma.publictransport.timetable
```
