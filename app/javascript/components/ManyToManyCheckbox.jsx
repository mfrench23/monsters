import React from "react"
import PropTypes from "prop-types"
class ManyToManyCheckbox extends React.Component {
  constructor () {
    super();
    this.toggleChecked = this.toggleChecked.bind(this);
  }

  toggleChecked () {
    this.props.callback( this.props.subheader, this.props.index );
    return;
  }

  render () {
    var opts = {};
    opts['id'] = this.props.identifier;
    opts['name'] = this.props.identifier;
    opts['key'] = this.props.identifier;
    opts['value'] = this.props.val;
    if(this.props.excluded) {
      opts['disabled'] = true;
    }
    return (
      <input {...opts} type="checkbox" checked={this.props.checked} onChange={this.toggleChecked} />
    );
  }
}

ManyToManyCheckbox.propTypes = {
  identifier: PropTypes.string,
  val: PropTypes.string,
  index: PropTypes.string,
  callback: PropTypes.func,
  checked: PropTypes.bool,
  excluded: PropTypes.bool
};
export default ManyToManyCheckbox
