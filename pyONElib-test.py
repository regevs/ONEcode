# A basic unittest for the pyONElib library
import unittest 
import ONEcode

schema = ONEcode.ONEschema(
  "P 3 seq                 SEQUENCE\n"
  "S 6 segseq              segment sequences - objects are 1:1 with those in seg file\n"
  "S 7 readseq             read sequences\n"
  "O S 1 3 DNA             sequence: the DNA string\n"
  "D I 1 6 STRING          id - sequence identifier; unnecessary for segments\n"
)

# Set up test case
class TestONEcode(unittest.TestCase):
    def test_basic_read_sequence(self):
        onefile = ONEcode.ONEfile("./TEST/small.seq", "r", schema, "", 1)
        self.assertTrue(onefile.readLine())
        self.assertEqual(onefile.lineType(), 'S')
        self.assertGreater(onefile.length(), 0)

# Main block to run the tests
if __name__ == '__main__':
    unittest.main()
    # To run the tests, use the command: python -m unittest pyONElib-test.py
    # Ensure that the pyONElib library is in your PYTHONPATH or the same directory as this script.
    # The test will check if the ONEfile can read a sequence file and if the schema is correctly defined.
    # Adjust the path to the sequence file as necessary for your environment.
    # The test assumes that the file "./TEST/small.seq" exists and is formatted according to the schema defined above.
    # If the file does not exist or is not formatted correctly, the test will fail.
    # You can add more tests to cover additional functionality of the ONEcode library as needed.        