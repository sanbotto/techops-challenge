For Security Groups:

```
lifecycle {
	create_before_destroy = true
}
```

&#x200B;

This is due to:

> "first the new Security Group resource must be created, then associated to possible Network Interface resources and finally the old Security Group can be detached and deleted".

[Source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#:~:text=first%20the%20new%20Security%20Group%20resource%20must%20be%20created%2C%20then%20associated%20to%20possible%20Network%20Interface%20resources%20and%20finally%20the%20old%20Security%20Group%20can%20be%20detached%20and%20deleted.)

&#x200B;

---
