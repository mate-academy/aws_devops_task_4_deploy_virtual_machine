The task requires the t2.micro instance type.

On my AWS account, t2.micro is not eligible for Free Tier.
AWS returns:

InvalidParameterCombination:
The specified instance type is not eligible for Free Tier.

The Free Tier eligible instance types available for my account are:
- c7i-flex.large
- t3.micro
- t4g.small
- t4g.micro
- t3.small
- m7i-flex.large

All task tests pass with the required t2.micro configuration.

Would it be acceptable to use t3.micro instead?