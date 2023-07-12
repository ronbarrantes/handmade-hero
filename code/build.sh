# Build.sh
# The build system for handmade hero

echo "Building the handmade project"
mkdir ../build
pushd ../build
clang -g -o handmade ../code/osx_main.mm
popd 
