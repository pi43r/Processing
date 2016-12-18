

String lines[] = loadStrings("list.txt");

println("there are " + lines.length + " lines in your file.");
println("");

for (int i = 0 ; i < lines.length; i++) {
  println(lines[i]);
}


