# postgresql-clr

The center log ratio is an isomorphism and an isometry defined as $\text{clr}: S^D \rightarrow U,\quad U\subset R^D$.

$$\text{clr}(x) = \left[\log\frac{x_1}{g(x)},\dots,\log\frac{x_D}{g(x)}\right],$$

where $g(x)$ is the geometric mean of $x$.

## The implementation follows

* [pycodamath](https://bitbucket.org/genomicepidemiology/pycodamath/src/master/) (version 1.0)
* [scipy](https://scipy.org/) (version 1.7.3)

## TODO

1. provide script to replace %%SCHEMA%% and load in database
2. provide usage examples
3. provide test
