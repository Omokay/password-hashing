#!/bin/bash

echo "PHP"
echo "---------------------------------------------"
php tests/test.php
if [ $? -ne 0 ]; then
    echo "FAIL."
    exit 1
fi
echo "---------------------------------------------"
echo ""

echo "RUBY"
echo "---------------------------------------------"
ruby tests/test.rb
if [ $? -ne 0 ]; then
    echo "FAIL."
    exit 1
fi
echo "---------------------------------------------"
echo ""

echo "C#"
echo "---------------------------------------------"
# Compile the C# test files
cp PasswordHash.cs ./tests
cd tests
mcs Test.cs PasswordHash.cs
mono Test.exe
if [ $? -ne 0 ]; then
    echo "FAIL."
    # Cleanup
    rm Test.exe
    rm PasswordHash.cs
    cd ..
    exit 1
fi
# Cleanup
rm Test.exe
rm PasswordHash.cs
cd ..
echo "---------------------------------------------"
echo ""

echo "Java"
echo "---------------------------------------------"
# Compile the Java test files
cp ./PasswordHash.java ./tests
cd ./tests
javac Test.java
java Test
if [ $? -ne 0 ]; then
    echo "FAIL."
    # Cleanup
    rm Test.class
    rm PasswordHash.class
    rm PasswordHash.java
    cd ..
    exit 1
fi
# Cleanup
rm ./PasswordHash.class
rm ./PasswordHash.java
rm ./Test.class
cd ..
echo "---------------------------------------------"
echo ""

echo "PHP<->Ruby Compatibility"
echo "---------------------------------------------"
ruby tests/testRubyPhpCompatibility.rb
if [ $? -ne 0 ]; then
    echo "FAIL."
    exit 1
fi
echo "---------------------------------------------"
echo ""

echo "PHP<->Java Compatibility"
echo "---------------------------------------------"
# Compile the Java test files
cp ./PasswordHash.java ./tests
cd ./tests
javac JavaAndPHPCompatibility.java
java JavaAndPHPCompatibility
if [ $? -ne 0 ]; then
    echo "FAIL."
    # Cleanup
    rm JavaAndPHPCompatibility.class
    rm PasswordHash.class
    rm PasswordHash.java
    cd ..
    exit 1
fi
# Cleanup
rm ./PasswordHash.class
rm ./PasswordHash.java
rm ./JavaAndPHPCompatibility.class
cd ..
echo "---------------------------------------------"
echo ""

echo "PHP<->C# Compatibility"
echo "---------------------------------------------"
# Compile the C# test files
cp PasswordHash.cs ./tests
cd tests
mcs CSharpAndPHPCompatibility.cs PasswordHash.cs
mono CSharpAndPHPCompatibility.exe
if [ $? -ne 0 ]; then
    echo "FAIL."
    # Cleanup
    rm CSharpAndPHPCompatibility.exe
    rm PasswordHash.cs
    cd ..
    exit 1
fi
# Cleanup
rm CSharpAndPHPCompatibility.exe
rm PasswordHash.cs
cd ..
echo "---------------------------------------------"
echo ""

echo "Correct terminology"
echo "---------------------------------------------"
./tests/uses-correct-terminology.sh
if [ $? -ne 0 ]; then
    echo "FAIL."
    exit 1
fi
echo "---------------------------------------------"
