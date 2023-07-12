# Build.sh
# The build system for handmade hero

OSX_LD_FLAGS="-framework AppKit"

echo "Building the handmade project"
mkdir ../build
pushd ../build
clang -g $OSX_LD_FLAGS -o handmade ../code/osx_main.mm
popd 
echo SUCCESS!!