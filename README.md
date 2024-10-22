# postgresql-clr

The center log ratio is an isomorphism and an isometry defined as $\text{clr}: S^D \rightarrow U,\quad U\subset R^D$.

$$\text{clr}(x) = \left[\log\frac{x_1}{g(x)},\dots,\log\frac{x_D}{g(x)}\right],$$

where $g(x)$ is the geometric mean of $x$.

## The implementation follows

* [pycodamath](https://bitbucket.org/genomicepidemiology/pycodamath/src/master/) (version 1.0)
* [scipy](https://scipy.org/) (version 1.7.3)

### Installation

You need a working postgresql database and a login role that has proper rights to create functions.
Note, the helper script provided does not take care of granting additional rights to these functions.

```bash
python install.py -d mydb -u mydbuser
```

For additional parametrization see the scripts help.

## TODO

1. provide usage examples
2. provide test
