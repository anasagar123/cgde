import pytest
from calculator import add, subtract

@pytest.fixture
def calculator_setup():
     print("Setting up the environment for calculator")

def test_add(calculator_setup):
     assert add(6,10) == 16

def test_subtract(calculator_setup):
     assert subtract(3,4) == -1