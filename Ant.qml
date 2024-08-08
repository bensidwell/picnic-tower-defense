import QtQuick

Item {
    id: root
    property int health: 100
    property int imageSize: 100
    property bool reachedEnd: false
    property int antID: 0

    property double xPathScaler: 1
    property double yPathScaler: 1

    signal antDied(bool reachedEnd)

    Image {
        id: antImage
        visible: true
        width: imageSize
        height: imageSize
        source: "qrc:/ant.png"
    }

    // Animation for ant to move along path
    PathAnimation {
        id: antPath
        running: true
        duration: 25000
        loops: 1
        onRunningChanged: checkAntProgress()

        target: root
        orientation: PathAnimation.TopFirst
        anchorPoint: Qt.point(antImage.width/2, antImage.height/2)

        // The path to the picnic basket
        path: Path {
            startX: 0 * xPathScaler; startY: 190 * yPathScaler

           PathCurve { x: 285 * xPathScaler;
                        y: 190 * yPathScaler}
           PathCurve { x: 285 * xPathScaler;
                        y: 460 * yPathScaler}

           PathCurve { x: 490 * xPathScaler;
                        y: 460 * yPathScaler}
           PathCurve { x: 490 * xPathScaler;
                        y: 650 * yPathScaler}

           PathCurve { x: 340 * xPathScaler;
                        y: 650 * yPathScaler}
           PathCurve { x: 340 * xPathScaler;
                        y: 870 * yPathScaler}

           PathCurve { x: 920 * xPathScaler;
                        y: 870 * yPathScaler}
           PathCurve { x: 920 * xPathScaler;
                        y: 580 * yPathScaler}

           PathCurve { x: 780 * xPathScaler;
                        y: 580 * yPathScaler}
           PathCurve { x: 780 * xPathScaler;
                        y: 330 * yPathScaler}

           PathCurve { x: 1340 * xPathScaler;
                        y: 330 * yPathScaler}
           PathCurve { x: 1340 * xPathScaler;
                        y: 730 * yPathScaler}
           PathCurve { x: 2000 * xPathScaler;
                        y: 730 * yPathScaler}
        }
    }


    // Called when ant reaches end of a path segment
    function checkAntProgress() {
        // Check if the ant is still moving
        if (antPath.running === true)
            return

        // It has reached the picnic basket
        root.reachedEnd = true
        root.antDied()
        root.destroy()
    }

    function dealDamage(damage) {
        console.log("taken damage " +damage)

        // Take damage
        health -= damage;

        // If health is below zero, kill the ant
        if (health < 0) {
            root.antDied(reachedEnd)
            //root.destroy()
        }
    }
}
