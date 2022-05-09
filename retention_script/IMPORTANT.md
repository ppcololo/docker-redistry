# About optional task:
Well, I could spend several hours and develop this script by myself, but does it worth to do it?  
It's like invent a wheel again. If we have a some base image\script\module and this module doing a lot
of things we need, we can use this BASE and add new features or modify it for our needs.  
This script has more than 700 stars on GitHub and works like a charm.
In this case I can't say I finished this task by myself, but I can say that I can provide you a script
which follows all your requirements. And yes, I spent some time for testing of course.  

So, we have several options how to execute this script:
* Lambda
* K8s Cronjob
* Jenkins pipeline
* Any EC2 instance and cron

For this script we can prepare config file with settings (`IMAGE_NAME:MAX_COUNT`):
calculator:5
job:10

and then run our script in the loop for every string:
```console
python3 registry.py -l user:password -r https://registry-hostname -i ${IMAGE_NAME} --delete --num {MAX_COUNT}
```

Also, we have to run garbage-collector task

## Garbage-collector
Garbage-collector job has to be executed after each run of deleting tags.  
Or automatically by adding script to Cron\Periodic folder inside Pod (example in values.yaml)