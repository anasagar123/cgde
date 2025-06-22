import pytest
from main import add # main means i ahve created main python file(main.py) and 


def test_addition():
     assert add(3,4) == 7
     assert add(1,1) == 2
     # assert add(-1,-2) == -4  # knowingly i given wrong of i will test then we can check it is giving right or wrong
     assert add(-1,-2) == -3    # here fixing the error
