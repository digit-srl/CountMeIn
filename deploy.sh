#!/bin/sh

fvm flutter build web --web-renderer canvaskit
echo ----------
echo build complete
firebase deploy --only hosting
echo ----------
echo hosting deploy complete
firebase deploy --only functions
echo ----------
echo functions deploy complete