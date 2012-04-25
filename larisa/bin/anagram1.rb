#!/usr/bin/env ruby

#Nos proporciona la clase OptionParser.
require 'optparse'
dictionary = "/usr/share/dict/words"

OptionParser.new do |opts|
  opts.banner = "Usage: anagram [ options ] word..."
  #Añade la opcion -d para poder añadir el diccionario que queramos:
  opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|
    dictionary = dict
  end
  #Añade la opcioon -h a la línea de comando:
  opts.on("-h", "--help", "Show this message") do
    #Imprime el propio objeto parser (que mostrara todas las opciones disponibles)
    puts opts
    exit
  end
  begin
    # Añade a ARGV la opcion -h si esta vacio
    ARGV << "-h" if ARGV.empty?
    # La exclamacion significaba que se modificaba el estado interno del objeto.
    opts.parse!(ARGV)
    # Por si la linea de comando es incorrecta, capturamos la exepcion:
    rescue OptionParser::ParseError => e
    STDERR.puts e.message, "\n", opts
    exit(-1)
  end
end

# convert "wombat" into "abmotw". All anagrams share a signature
def signature_of(word)
  # Word.unpack('c*') nos devuelve la palabra en sus numeros ASCII (en 0 o más caracteres --> c*).
  # A continuacion ordenamos los caracteres y volvemos a convertir la cadena a caracteres.
  word.unpack("c*").sort.pack("c*")
end

#Se crea un hash pasandole un bloque creando un hash en el que cada elemento del hash si no esta inicializado, lo haces
#automaticamente con el contenido del bloque, en este caso vacio.
signatures = Hash.new { |h,k| h[k] = [] }
File.foreach(dictionary) do |line|
  #Elimina el retorno de carro final de la linea (hasta el ultimo caracter, podemos definir cual es el separador)
  word = line.chomp
  signature = signature_of(word)
  # Guardamos en el hash el valor de la clave. Al haber inicializado el hash a vacio, esta linea no da error.
  signatures[signature] << word
end

ARGV.each do |word|
  s = signature_of(word)
  if signatures[s].length != 0
    puts "Anagrams of '#{word}': #{signatures[s].join(', ')}"
  else
    puts "No anagrams of '#{word}' found in #{dictionary}"
  end
end