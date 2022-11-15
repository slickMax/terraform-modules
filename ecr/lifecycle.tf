resource "aws_ecr_lifecycle_policy" "repo" {
  repository = aws_ecr_repository.repo.name
 
  policy = jsonencode({
   rules = [{
     rulePriority = 1
     description  = "keep last 20 images"
     action       = {
       type = "expire"
     }
     selection     = {
       tagStatus   = "any"
       countType   = "imageCountMoreThan"
       countNumber = 20
     }
   }]
  })
}
