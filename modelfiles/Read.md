# Commands
## Create turbo-coder-8gb
```bash
ollama create turbo-coder-8gb -f ./turbo-coder-8gb.Modelfile
```
```bash
# use the modelfile
ollama run turbo-coder:1.3b "#!turbo
// Otimize esta função em Go
func CalculateFibonacci(n int) int {"

# or

ollama run turbo-coder:8gb "#!design
Projete um sistema de cache distribuído para alta carga com: 
- 500k req/seg 
- Consistência eventual 
- TTL automático"

```
## Create lead-stack
```bash
# Com variável de ambiente para modo 16GB
RAM_AVAILABLE=16384 ollama create lead-stack -f ./lead-stack.Modelfile
```

```bash
# use the modelfile
ollama run lead-stack "#deep
Projete microserviço de pagamentos com:
- NestJS + GraphQL Federation
- MongoDB transactions
- Circuit breaker
- 3 replicas no Kubernetes"

# or

ollama run lead-stack "Refatore para Java 21:
public class UserService {
  private List<User> users = new ArrayList<>();
  // ... método de busca
}"
```

## Create techlead-ultra-perf
```bash
# Com variável de ambiente para modo 16GB
RAM_AVAILABLE=16384 ollama create techlead-ultra-perf -f ./techlead-ultra-perf.Modelfile
```

```bash
# use the modelfile
OLLAMA_MODEL=techlead-ultra-perf OLLAMA_PROMPT_PREFIX="#deep " ollama run "#deep API em NestJS com:
- GraphQL Federation
- MongoDB transactions
- Kafka para eventos
- Circuit breaker"
```
