import { Nullable } from "@/shared/types";
import { IId } from "@/shared/interfaces";

export interface IProductWithoutId {
  name?: Nullable<string>;
  completed: boolean;
}
export interface IProduct extends IId, IProductWithoutId {}
