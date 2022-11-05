# """
# This problem was asked by Uber.
# Given an array of integers, return a new array such that each element at index i of the new array is the product of all the numbers in the original array except the one at i. Solve it without using division and in O(n) time.
# For example, if our input was [1, 2, 3, 4, 5], the expected output would be [120, 60, 40, 30, 24]. If our input was [3, 2, 1], the expected output would be [2, 3, 6].
# https://dailycodingproblem.com/
# """

def problem2solver(numbers):
  numbers_product = []
  for i in range(0, len(numbers)):
    product = 1
    for j in range(0, len(numbers)):
      if not i is j:
        product *= numbers[j]
        
    numbers_product.append(product)
  return numbers_product

if __name__ == '__main__':
  # Read input, numbers separated by commas
  numbers = [int(n) for n in input().split(',')]
  print(problem2solver(numbers))