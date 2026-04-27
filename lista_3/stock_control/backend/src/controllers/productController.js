function parseId(rawId) {
  const id = Number(rawId);
  return Number.isInteger(id) && id > 0 ? id : null;
}

export class ProductController {
  constructor(productService) {
    this.productService = productService;
  }

  list = async (_req, res) => {
    const products = await this.productService.listProducts();
    res.json(products);
  };

  create = async (req, res) => {
    const product = await this.productService.createProduct(req.body);
    res.status(201).json(product);
  };

  update = async (req, res) => {
    const id = parseId(req.params.id);
    if (id === null) {
      res.status(400).json({ message: 'Invalid product id.' });
      return;
    }

    const product = await this.productService.updateProduct(id, req.body);
    if (!product) {
      res.status(404).json({ message: 'Product not found.' });
      return;
    }

    res.json(product);
  };

  updateAmount = async (req, res) => {
    const id = parseId(req.params.id);
    if (id === null) {
      res.status(400).json({ message: 'Invalid product id.' });
      return;
    }

    const product = await this.productService.updateProductAmount(id, req.body);
    if (!product) {
      res.status(404).json({ message: 'Product not found.' });
      return;
    }

    res.json(product);
  };

  remove = async (req, res) => {
    const id = parseId(req.params.id);
    if (id === null) {
      res.status(400).json({ message: 'Invalid product id.' });
      return;
    }

    const removed = await this.productService.deleteProduct(id);
    if (!removed) {
      res.status(404).json({ message: 'Product not found.' });
      return;
    }

    res.status(204).send();
  };
}
