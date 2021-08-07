FROM public.ecr.aws/lambda/python:3.8

COPY application.py ./

CMD ["application.handler"]
