String myFileName = "list.txt";

String lines[] = loadStrings(myFileName);

println("there are " + lines.length + " lines in your file.");
println("");

for (int i = 0 ; i < lines.length ; i++) {
  println("The content of the Array   lines   element [" + i + "] is: \"" +lines[i] + "\"");
}
