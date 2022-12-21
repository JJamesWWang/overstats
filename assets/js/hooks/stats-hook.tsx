import React from "react";
import { createRoot } from "react-dom/client";

const StatsPage = () => {};

const StatsHook = {
  mounted() {
    let data = this.el.dataset;
    console.log(data);

    const element = document.getElementById("stats-hook");
    const root = createRoot(element);
    root.render(<StatsPage data={data} />);
  },
};

export default StatsHook;
