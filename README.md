# README

Testing out using lambda in a Docker.

To create:

1. Build the image `docker build -t lambda-test`

1. Test the docker works:

    * start the docker image `docker run -p 9000:8080 lambda-test`

    * trigger the lambda function `curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'`

1. Create a repository on AWS ECR to host images:

    * Link Docker CLI to AWS ECR: `aws ecr get-login-password --region us-east-2 --profile personal | docker login --username AWS --password-stdin 382798410023.dkr.ecr.us-east-2.amazonaws.com`

    * Create a new repository in AWS ECR `aws ecr create-repository --profile personal --repository-name lambda-test --image-scanning-configuration scanOnPush=true --image-tag-mutability MUTABLE`

1. Upload the image to AWS container registry:

    * Tag latest image to AWS ECR `docker tag  lambda-test:latest 382798410023.dkr.ecr.us-east-2.amazonaws.com/lambda-test:latest`

    * Push the image `docker push 382798410023.dkr.ecr.us-east-2.amazonaws.com/lambda-test:latest`

1. Permission the ECR so that it can run lambda functions, see [AWS docs](https://docs.aws.amazon.com/lambda/latest/dg/configuration-images.html)

1. Create the function by logging into the management console, browse to create function in the Lambda section. Select 'from container image' then give it a name and browse to the correct image in ECR.

1. Invoke the function from the command line with `aws lambda invoke --profile personal --function-name "lambda-test" /dev/stdout`

# Making changes

1. Make code changes.

1. Rebuild the docker image, run, test etc.

1. Re-tag the latest image to the AWS ECR image.

1. Push the new image then invoke it to check (may take a few seconds for everything to update).


# Useful resources

[Managing different profiles in AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

[Medium tutorial](https://www.varokas.com/aws-lambda-docker/)

[AWS Docs](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html#images-create-from-base.title)
