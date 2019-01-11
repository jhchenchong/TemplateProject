#!/bin/bash

VersionString=`grep -E 's.version.*=' TemplateProject.podspec`
VersionNumber=`tr -cd 0-9 <<<"$VersionString"`

NewVersionNumber=$(($VersionNumber + 1))
LineNumber=`grep -nE 's.version.*=' TemplateProject.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" TemplateProject.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
#pod trunk push TemplateProject.podspec --verbose --allow-warnings --use-libraries
pod repo push private_pods TemplateProject.podspec --verbose --allow-warnings

