# Delphi10, Firedac-Multithread-Connection-problem

Project in Delphi 10 Seattle shows a connection problem in a multithread application based on FireDAC. 
Program creates five threads which connect to Firebird database and run SQL on system tables.
When one of threads has a problem with connection some (or even all - it's random) other threads are suspended. Only when TFDConnection returns an error all other suspended threads can go on correctly.

Run program write correct server and file for database1 and database2. Leave Database3 with incorrect IP. Then start threads. You can see that all threads try to connect to FB server. Thread 3 which connects to a bad IP hangs. But not only this one! Also other (or even all) threads hang.

With IBX problem does't appear.

# The question is: how to do it good?
How to do it in order to omit this problem?
How can I set upt timeout for the connection?